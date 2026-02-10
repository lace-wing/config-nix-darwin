ENTRY := main.icas
INFS := lib.icas main.icas
OUTFS := out.icas

default: run

cat:
	@rm -f $(OUTFS)
	@for file in $(INFS); do \
			if [ -f "$$file" ]; then \
				cat "$$file" >> $(OUTFS); \
			fi \
		done

run:
	giac $(ENTRY) 2>&1 | awk '/^\/\// { if (!f) { print ""; f=1 } next } { print; f=0 }'

clean:
	@rm -f $(OUTFS)
	@rm -f session.tex

