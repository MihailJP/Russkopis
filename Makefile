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
	zip -9r $(font).zip $(font)

readme-rus: $(rusdocs)

README.ru.cp1251: README.ru.utf8
	iconv -f utf-8 -t cp1251 $< > $@
README.ru.iso8859-5: README.ru.utf8
	iconv -f utf-8 -t iso8859-5 $< > $@
README.ru.koi8: README.ru.utf8
	iconv -f utf-8 -t koi8-r $< > $@

readme-jpn: $(jpndocs)

README.ja.sjis: README.ja.utf8
	iconv -f utf-8 -t sjis $< > $@
README.ja.euc: README.ja.utf8
	iconv -f utf-8 -t euc-jp $< > $@

.PHONY: clean
clean:
	rm -rf $(objs) $(font) $(font).zip $(rusdocs) $(jpndocs)
