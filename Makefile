# Russkopis Makefile

font = russkopis
targets = $(font) readme-rus readme-jpn
fonts = Russkopis-Normalny Russkopis-Zhirny
objs = $(addsuffix .otf,$(fonts))
rusdocs = README.ru.koi8 README.ru.cp1251 README.ru.iso8859-5
jpndocs = README.ja.sjis README.ja.euc
docs = README README.ru.utf8 $(rusdocs) README.ja.utf8 $(jpndocs) LICENSE AUTHORS

.PHONY: all
all: $(targets)

$(font): $(objs)

%.otf: %.sfd
	fontforge -lang=ff -c "Open(\"$<\");Generate(\"$@\");Close()"

dist: all
	mkdir $(font)
	cp $(objs) $(docs) $(font)
	zip -9 $(font).zip $(font)

readme-rus: $(rusdocs)

README.ru.cp1251: README.ru.utf8
	iconv --from-code=utf8 --to-code=cp1251 --output=$@ $<
README.ru.iso8859-5: README.ru.utf8
	iconv --from-code=utf8 --to-code=iso8859-5 --output=$@ $<
README.ru.koi8: README.ru.utf8
	iconv --from-code=utf8 --to-code=koi8-r --output=$@ $<

readme-jpn: $(jpndocs)

README.ja.sjis: README.ja.utf8
	iconv --from-code=utf8 --to-code=sjis --output=$@ $<
README.ja.euc: README.ja.utf8
	iconv --from-code=utf8 --to-code=euc-jp --output=$@ $<

.PHONY: clean
clean:
	rm -rf $(objs) $(font) $(font).zip $(rusdocs) $(jpndocs)
