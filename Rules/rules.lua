
----------------------------------------------------------------------------------------------------------------------
-- Important Note: Below defined XSS and SQLi protection rules are just for demo purpose, they are not tested at all.
----------------------------------------------------------------------------------------------------------------------

-- Assigning a Regular expression to xss variable. the regular expression is basically a Lua string.
local xss = [[(<.*>)|(prompt\()|(alert\()|(confirm\()|(eval\()|(window\.)|(document\.)(fscommand)|(javascript:)|(onabort)|(onactivate)|(onafterprint)|(onafterupdate)|(onbeforeactivate)|(onbeforecopy)|(onbeforecut)|(onbeforedeactivate)|(onbeforeeditfocus)|(onbeforepaste)|(onbeforeprint)|(onbeforeunload)|(onbegin)|(onblur)|(onbounce)|(oncanplay)|(oncanplaythrough)|(oncellchange)|(onchange)|(onclick)|(oncontextmenu)|(oncontrolselect)|(oncopy)|(oncut)|(ondataavailable)|(ondatasetchanged)|(ondatasetcomplete)|(ondblclick)|(ondeactivate)|(ondragdrop)|(ondragend)|(ondragenter)|(ondragleave)|(ondragover)|(ondrag)|(ondragstart)|(ondrop)|(ondurationchange)|(onemptied)|(onended)|(onend)|(onerror)|(onerrorupdate)|(onfilterchange)|(onfinish)|(onfocusin)|(onfocusout)|(onfocus)|(onformchange)|(onforminput)|(onhashchange)|(onhelp)|(oninput)|(oninvalid)|(onkeydown)|(onkeypress)|(onkeyup)|(onlayoutcomplete)|(onloadeddata)|(onloadedmetadata)|(onload)|(onloadstart)|(onlosecapture)|(onmediacomplete)|(onmediaerror)|(onmessage)|(onmousedown)|(onmouseenter)|(onmouseleave)|(onmousemove)|(onmouseout)|(onmouseover)|(onmouseup)|(onmousewheel)|(onmoveend)|(onmove)|(onmovestart)|(onoffline)|(ononline)|(onoutofsync)|(onpagehide)|(onpageshow)|(onpaste)|(onpause)|(onplaying)|(onplay)|(onpopstate)|(onprogress)|(onpropertychange)|(onratechange)|(onreadystatechange)|(onredo)|(onrepeat)|(onreset)|(onresizeend)|(onresize)|(onresizestart)|(onresume)|(onreverse)|(onrowdelete)|(onrowexit)|(onrowinserted)|(onrowsenter)|(onscroll)|(onseeked)|(onseeking)|(onseek)|(onselectionchange)|(onselect)|(onselectstart)|(onshow)|(onstalled)|(onstart)|(onstop)|(onstorage)|(onsubmit)|(onsuspend)|(onsyncrestored)|(ontimeerror)|(ontimeupdate)|(ontrackchange)|(onundo)|(onunload)|(onurlflip)|(onvolumechange)|(onwaiting)|(seeksegmenttime)]]

-- Assigning a Regular expression to sqli variable. the regular expression is basically a Lua string.
local sqli = [[((['`´’‘])|(\/\*\!?|\*\/|\-\-[\s\r\n\v\f]|(?:--[^-]*-)|([^\-&])#.*[\s\r\n\v\f]|;?\\x00)|(\bunion[\s\\*\/]{1,100}?\bselect\b)|(^[\"'`´’‘;]+|[\"'`´’‘;]+$)|(?i:(\!\=|\&\&|\|\||>>|<<|>=|<=|<>|<=>|xor|rlike|regexp|isnull)|(?:not\s+between\s+0\s+and)|(?:is\s+null)|(like\s+null)|(?:(?:^|\W)in[+\s]*\([\s\d\"]+[^()]*\))|(?:xor|<>|rlike(?:\s+binary)?)|(?:regexp\s+binary))|(?i:(?:m(?:s(?:ysaccessobjects|msysaces|msysobjects|msysqueries|msysrelationships|msysaccessstorage|msysaccessxml|msysmodules|msysmodules2|db)|aster\.\.sysdatabases|ysql\.db)|s(?:ys(?:\.database_name|aux)|chema(?:\W*\(|_name)|qlite(_temp)?_master)|d(?:atabas|b_nam)e\W*\(|information_schema|pg_(catalog|toast)|northwind|tempdb))|(?i:\btable_name\b)|(?i:(?:,.*[)\da-f(\"|'|`|´|’|‘)](\"|'|`|´|’|‘)(?:(\"|'|`|´|’|‘).*(\"|'|`|´|’|‘)|\Z|[^(\"|'|`|´|’|‘)]+))|(?:\Wselect.+\W*from)|((?:select|create|rename|truncate|load|alter|delete|update|insert|desc)\s*\(\s*space\s*\()))]]

-- We are trying to match xss variable with all the values, for special matches like URI, QUERY_FIELD (names), HEADER_VALUES, METHOD, POST_FIELD (names), COOKIE_NAMES and HEADER_NAMES you need to write match conditions specifically
-- * meaning: QUERY_STRING, POST_DATA, POST_BODY, COOKIE_VALUES
if match("*", xss ,REGEX) or match("URI,QUERY_FIELDS,HEADER_VALUES", xss ,REGEX) then
	block("XSS_BLOCK", 301, 0, "/blocked.htm")
elseif match("*", sqli ,REGEX) then
	block("SQLI_BLOCK", 301, 0, "/blocked.htm")
end