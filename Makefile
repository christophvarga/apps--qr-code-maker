.PHONY: install test test-report

install:
	pip install -r requirements.txt
	playwright install chromium

test:
	pytest 87_tests/ -v --tb=short

test-report:
	@TS=$$(date +%Y%m%d-%H%M); \
	TEST_REPORT_DIR=89_output/test_reports/$$TS; \
	export TEST_REPORT_DIR; \
	mkdir -p "$$TEST_REPORT_DIR"; \
	pytest 87_tests/ --junitxml="$$TEST_REPORT_DIR/junit-py.xml" \
		--cov --cov-report=xml:"$$TEST_REPORT_DIR/coverage-py.xml" || true; \
	rm -f 89_output/test_reports/latest && ln -s "$$TS" 89_output/test_reports/latest || true; \
	echo "Testartefakte: $$TEST_REPORT_DIR"
