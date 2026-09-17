import argparse
import os
import time

from dhanhq import DhanContext, dhanhq


def as_float(position: dict, *names: str) -> float:
	for name in names:
		value = position.get(name)
		if value not in (None, ""):
			return float(value)
	return 0.0


def close_position(client: dhanhq, position: dict, dry_run: bool) -> None:
	quantity = abs(int(as_float(position, "netQty", "netQuantity")))
	if quantity == 0:
		return

	transaction_type = "SELL" if as_float(position, "netQty", "netQuantity") > 0 else "BUY"
	security_id = str(position["securityId"])
	exchange_segment = position.get("exchangeSegment", "NSE_EQ")
	product_type = position.get("productType", "INTRADAY")

	if dry_run:
		print(f"DRY RUN: {transaction_type} {quantity} of {security_id} on {exchange_segment}")
		return

	response = client.place_order(
		security_id=security_id,
		exchange_segment=exchange_segment,
		transaction_type=transaction_type,
		quantity=quantity,
		order_type="MARKET",
		product_type=product_type,
		price=0,
		tag="pnl-exit",
	)
	print(f"Exit submitted for {security_id}: {response}")


def monitor_pnl(
	client: dhanhq,
	profit_target: float | None,
	loss_limit: float | None,
	profit_percent: float | None,
	loss_percent: float | None,
	interval: float,
	dry_run: bool,
) -> None:
	triggered_positions: set[str] = set()
	while True:
		positions = client.get_positions()
		for position in positions if isinstance(positions, list) else positions.get("data", []):
			position_key = str(position.get("securityId"))
			if position_key in triggered_positions:
				continue
			pnl = as_float(position, "realizedProfit") + as_float(position, "unrealizedProfit")
			entry_value = abs(
				as_float(position, "costPrice")
				* as_float(position, "netQty", "netQuantity")
			)
			pnl_percent = (pnl / entry_value * 100) if entry_value else 0.0
			hit_profit = (profit_target is not None and pnl >= profit_target) or (
				profit_percent is not None and pnl_percent >= profit_percent
			)
			hit_loss = (loss_limit is not None and pnl <= -abs(loss_limit)) or (
				loss_percent is not None and pnl_percent <= -abs(loss_percent)
			)
			if hit_profit or hit_loss:
				print(f"Exit trigger: P&L={pnl:.2f}, P&L%={pnl_percent:.2f}")
				close_position(client, position, dry_run)
				triggered_positions.add(position_key)
		time.sleep(interval)


def main() -> None:
	parser = argparse.ArgumentParser(description="Dhan position P&L exit monitor")
	parser.add_argument("--profit", type=float, help="Exit at this total profit in rupees")
	parser.add_argument("--loss", type=float, help="Exit at this total loss in rupees")
	parser.add_argument("--profit-percent", type=float, help="Exit at this profit percentage")
	parser.add_argument("--loss-percent", type=float, help="Exit at this loss percentage")
	parser.add_argument("--interval", type=float, default=3, help="Polling interval in seconds")
	parser.add_argument("--live", action="store_true", help="Submit market exit orders")
	args = parser.parse_args()

	if not any((args.profit, args.loss, args.profit_percent, args.loss_percent)):
		parser.error("provide at least one P&L target")
	if args.interval <= 0:
		parser.error("interval must be greater than zero")
	context = DhanContext(os.environ["DHAN_CLIENT_ID"], os.environ["DHAN_ACCESS_TOKEN"])
	client = dhanhq(context)
	monitor_pnl(
		client,
		args.profit,
		args.loss,
		args.profit_percent,
		args.loss_percent,
		args.interval,
		dry_run=not args.live,
	)


if __name__ == "__main__":
	main()