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


deploy: prod
	cd apps/portfolio_yeasin/build/web && \
	git init && \
	git config user.email 46500228+yeasin50@users.noreply.github.com && \
	git config user.name yeasin50 && \
	git remote add origin https://github.com/yeasin50/portfolio.git && \
	git checkout -b gh-pages || git checkout gh-pages && \
	git add --all && \
	git commit -m "Deploy from Makefile" || echo "No changes to commit" && \
	git push origin gh-pages --force
