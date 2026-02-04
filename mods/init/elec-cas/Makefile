INFS := lib.cas main.cas
OUTFS := out.cas

default: cat run

cat:
	@rm -f $(OUTFS)
	@for file in $(INFS); do \
			if [ -f "$$file" ]; then \
				cat "$$file" >> $(OUTFS); \
			fi \
		done

run:
	giac $(OUTFS) 2>&1 | awk '/^\/\// { if (!f) { print ""; f=1 } next } { print; f=0 }'

clean:
	@rm -f $(OUTFS)
	@rm -f session.tex

