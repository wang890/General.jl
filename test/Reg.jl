using General.Reg

str = "// Space and Time (chapter 1 of ISO 31-1992)\r\n\r\n    type Angle = \
Real (\r\n        final quantity=\"Angle\",\r\n        final unit=\"rad\",\r\n        displayUnit=\"deg\")"

note::String, note_offset::Int = Reg.get_match_capture(str, r"([\s\S]+)type", "//"=>"#")

a =5