
m = Map("cpulimit", translate("Cpulimit"), translate("Use cpulimit to limit CPU usage of a process."))
s = m:section(TypedSection, "list", translate("Settings"))
s.template = "cbi/tblsection"
s.anonymous = true
s.addremove = true

enable = s:option(Flag, "enabled", translate("enable"))
enable.optional = false
enable.rmempty = false

local pscmd="ps | awk '{print $5}' | sed '1d' | sort -k2n | uniq | sed '/^\\\[/d' | sed '/sed/d' | sed '/awk/d' | sed '/hostapd/d' | sed '/pppd/d' | sed '/mwan3/d' | sed '/sleep/d' | sed '/sort/d' | sed '/ps/d' | sed '/uniq/d' | awk -F '/' '{print $NF}'"
local shellpipe = io.popen(pscmd,"r")


exename = s:option(Value, "exename", translate("exename"), translate("name of the executable program file. CAN NOT BE A PATH!"))
exename.optional = false
exename.rmempty = false
exename.default = ""
for psvalue in shellpipe:lines() do
	exename:value(psvalue)
end

includechildren = s:option(Flag, "includechildren", translate("include children"), translate("limit also the children processes. THIS MAY LEAD TO HIGH LOAD OF CPULIMIT!"))
includechildren.optional = false
includechildren.rmempty = false

limit = s:option(Value, "limit", translate("limit (%)"))
limit.optional = false
limit.rmempty = false
limit.default = "50"
limit:value("100")
limit:value("90")
limit:value("80")
limit:value("70")
limit:value("60")
limit:value("50")
limit:value("40")
limit:value("30")
limit:value("20")
limit:value("10")

return m
