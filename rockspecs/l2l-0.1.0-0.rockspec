package = "l2l"
version = "0.1.0-0"
source = {
	url = "git://github.com/meric/l2l.git",
	tag = "0.1.0"
}
description = {
	summary = "FILLME",
	detailed = [[
		FILLME
		FILLME
	]],
	homepage = "https://github.com/meric/l2l.git",
	maintainer = "Eric Man (meric)",
	license = "2-clause BSD"
}
dependencies = {
	"lua >= 5.1"
}
build = {
	type = 'builtin',
	modules = {
		['l2l'] = 'l2l/init.lua'
		['l2l.compiler'] = 'l2l/compiler.lua'
		['l2l.import'] = 'l2l/import.lua'
		['l2l.reader'] = 'l2l/reader.lua'
		['l2l.exception'] = 'l2l/exception.lua'
		['l2l.itertools'] = 'l2l/itertools.lua'
		['l2l.core'] = 'l2l/core.lua'
	}
}
