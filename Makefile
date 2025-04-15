.PHONY: run-server run-portfolio prod

run-server:
	cd server && go run cmd/main.go && cd ..

run-portfolio: run-server
	cd apps/portfolio_yeasin && flutter run -d web-server -t lib/main_dev.dart


dev:
	@echo "Running in tmux (separate windows)..."
	@tmux new-session -d -s dev_session 'cd server && go run cmd/main.go' \; \
		new-window -t dev_session:1 'cd apps/portfolio_yeasin && flutter run -d web-server -t lib/main.dart' \; \
		attach-session -t dev_session

 

prod:
	cd apps/portfolio_yeasin && \
	flutter clean && \
	flutter pub get && \
	flutter build web --release -t lib/main_prod.dart
