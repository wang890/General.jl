using General.Reg

str = "// Space and Time (chapter 1 of ISO 31-1992)\r\n\r\n    type Angle = \
Real (\r\n        final quantity=\"Angle\",\r\n        final unit=\"rad\",\r\n        displayUnit=\"deg\")"

note, note_offset = Reg.get_match_capture(str, r"([\s\S]+)type", "//"=>"#")

real_fvs ="Real (\r\n        final quantity=\"Angle\",\r\n        final unit=\"rad\",\r\n        displayUnit=\"deg\")"


fvs, fvs_offset =  Reg.get_match_capture(real_fvs, r"\(([\s\S]+)\)")

fvs_splits = split(string(fvs), ",")

a =5