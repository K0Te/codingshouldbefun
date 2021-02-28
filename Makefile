build:
	DYLD_INSERT_LIBRARIES=/Users/kote/github/macos11-haskell-workaround/macos11ghcwa.dylib stack build
	stack exec site rebuild
	stack exec site watch

.PHONY: lint
lint:
	hlint site --report

.PHONY: format
format:
	find site -name '*.hs' | xargs stylish-haskell -i

