.PHONY: server dev prod

PORT ?= 8082
MAIN_FILE ?= apps/portfolio_yeasin/lib/main_dev.dart

.PHONY: run_web

version:
	@fvm flutter --version

format_check:
	dart format -o none --set-exit-if-changed .

run:
	# @sudo kill -9 $$(sudo lsof -t -i :$(PORT)) 2>/dev/null || true
	@fvm flutter run -t $(MAIN_FILE)  -d  web-server 
	# --web-port=$(PORT) --web-hostname=localhost 
	# sleep 5 && \
	# echo "http://localhost:$(PORT)" | xclip -selection clipboard && \
	# echo "URL copied to clipboard"

bs:
	fvm dart pub global run melos bootstrap 

server:
	@echo "======================================="
	@echo "🚀 Running local server"
	@echo "======================================="
	cd server && air 

dev: 
	@echo "======================================="
	@echo "🚀 Running Yeasin's Portfolio (Dev Mode)"
	@echo "======================================="
	@echo "🧹 flutter clean..."
	flutter clean
	@echo "📦 flutter pub get..."
	fvm flutter pub get
	cd apps/portfolio_yeasin && \
	fvm flutter run -d web-server -t lib/main_dev.dart


prod_local:
	cd apps/portfolio_yeasin && \
	fvm flutter clean && \
	fvm flutter pub get && \
	fvm flutter build web --release -t lib/main_dev.dart --base-href /


prod:
	cd apps/portfolio_yeasin && \
	fvm flutter clean && \
	fvm flutter pub get && \
	fvm flutter build web --release -t lib/main_prod.dart --base-href /portfolio/



deploy: prod
	cd apps/portfolio_yeasin/build/web && \
	git init && \
	git remote add origin git@github.com:yeasin50/portfolio.git && \
	git checkout -b gh-pages || git checkout gh-pages && \
	git add --all && \
	git commit -m "Deploy from Makefile" || echo "No changes to commit" && \
	git push origin gh-pages --force

generate: 
	# cd ./apps/admin_app && dart run build_runner watch -d
	melos run watch_runner
