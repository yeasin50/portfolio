.PHONY: server dev prod

server:
	@echo "======================================="
	@echo "🚀 Running local server"
	@echo "======================================="
	cd server && go run cmd/main.go

dev: 
	@echo "======================================="
	@echo "🚀 Running Yeasin's Portfolio (Dev Mode)"
	@echo "======================================="
	@echo "🧹 flutter clean..."
	flutter clean
	@echo "📦 flutter pub get..."
	flutter pub get
	cd apps/portfolio_yeasin && \
	flutter run -d web-server -t lib/main_dev.dart



prod:
	cd apps/portfolio_yeasin && \
	flutter clean && \
	flutter pub get && \
	flutter build web --release -t lib/main_prod.dart
