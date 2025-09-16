# Build Flutter web
flutter build web

# Deploy to gh-pages
git add -f build/web/*
git commit -m "Deploy Flutter web"
git subtree push --prefix build/web origin gh-pages
