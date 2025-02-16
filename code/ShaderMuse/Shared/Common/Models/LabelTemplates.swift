//
//  Copyright © 2022 James Boo. All rights reserved.
//

//Compilation

var labelTemplatesAll = [
    ["Standard SLE001","Labels","Standard","Address Label (Letter) - 10x2","iso-letter","8.500","11.000","4.000","1.000","0.189","0.000","10","2","0.156","0.500"],
    ["Standard SLE002","Labels","Standard","Address/Shipping (Letter) - 3x2","iso-letter","8.500","11.000","4.000","3.333","0.188","0.000","3","2","0.156","0.500"],
    ["Standard SLE003","Labels","Standard","Address/Shipping (Letter) - 5x2","iso-letter","8.500","11.000","4.000","2.000","0.188","0.000","5","2","0.156","0.500"],
    ["Standard SLE004","Labels","Standard","Address Label (Letter) - 7x2","iso-letter","8.500","11.000","4.000","1.333","0.188","0.000","7","2","0.156","0.833"],
    ["Standard SLE005","Labels","Standard","Address Label (Letter) - 10x3","iso-letter","8.500","11.000","2.625","1.000","0.125","0.000","10","3","0.188","0.500"],
]


var labelTemplates = labelTemplatesAll.filter {
    $0[1].contains("Labels") && $0[2].contains("Standard")
}

var labelTemplatesCount = 11

//var categories = ["Labels","Envelopes","Cards & Tags","Papers"]
var categories = ["Labels","Envelopes","Cards & Tags","Papers"]
//Label Rolls "Envelopes", - until printer to test on iOS


var vendorsCards = ["Agipa","AOne","APLI","Avery","Herma","MACO","MaySpies","PIMACO","RankXerox","Standard"]

//var vendorsLabels = ["Agipa","AOne","APLI","Avery","Standard","Brother","ERO","Formtec","Herma","HP","MACO","MACTac","MaySpies","PIMACO","RankXerox","Zweckform"]

var vendorsLabels = ["Agipa","AOne","APLI","Avery","Standard","ERO","Formtec","Herma","HP","MACO","MACTac","MaySpies","PIMACO","RankXerox","Zweckform"]

var vendors = vendorsLabels

//var fontNames = ["Helvetica","Helvetica Bold","American Typewriter Bold","Arial","Arial Bold","Arial Italic"]
/*
var fontNames = ["Academy Engraved LET",
                 "American Typewriter Bold",
                 "Arial","Arial Bold",
                 "Arial Italic",
                 "Helvetica",
                 "Helvetica Bold"
                ]
*/

var fullFontNames = [
    "American Typewriter",
    "American Typewriter Bold",
    "Arial",
    "Arial Bold",
    "Arial Bold Italic",
    "Arial Italic",
    "CCodeMICR",
    "CCodeCMC7",
    "CCodeCMC7I",
    "CCodeCMC7II",
    "CCodeCMC7III",
    "CCodeCMC7IV",
    "CCodeSecuritySANS_S",
    "CCodeSecuritySANS_T",
    "CCodeSecuritySERIF_S",
    "CCodeSecuritySERIF_T",
    "Courier",
    "Courier Bold",
    "Courier New",
    "Courier New Bold",
    "Courier New Bold Italic",
    "Courier New Italic",
    "Helvetica",
    "Helvetica Bold",
    "Helvetica Neue",
    "Helvetica Neue Bold",
    "Helvetica Neue Bold Italic",
    "Helvetica Neue Italic",
    "PingFang HK Regular",
    "PingFang SC Regular",
    "PingFang TC Regular",
    "Times New Roman",
    "Times New Roman Bold",
    "Times New Roman Bold Italic",
    "Times New Roman Italic",
    "Trebuchet MS",
    "Trebuchet MS Bold",
    "Trebuchet MS Bold Italic",
    "Trebuchet MS Italic",
    "Verdana",
    "Verdana Bold",
    "Verdana Bold Italic",
    "Verdana Italic"

]
var fontNames = [
    "American Typewriter",
    "American Typewriter Bold",
    "Arial",
    "Arial Bold",
    "Arial Bold Italic",
    "Arial Italic",
    "Courier",
    "Courier Bold",
    "Courier New",
    "Courier New Bold",
    "Courier New Bold Italic",
    "Courier New Italic",
    "Helvetica",
    "Helvetica Bold",
    "Helvetica Neue",
    "Helvetica Neue Bold",
    "Helvetica Neue Bold Italic",
    "Helvetica Neue Italic",
    "PingFang HK Regular",
    "PingFang SC Regular",
    "PingFang TC Regular",
    "Times New Roman",
    "Times New Roman Bold",
    "Times New Roman Bold Italic",
    "Times New Roman Italic",
    "Trebuchet MS",
    "Trebuchet MS Bold",
    "Trebuchet MS Bold Italic",
    "Trebuchet MS Italic",
    "Verdana",
    "Verdana Bold",
    "Verdana Bold Italic",
    "Verdana Italic"
]

var qrErrorLevel = ["L","M","Q","H"]

var barcodeFontNames = ["CCode39_S3",
                        "CCodeIPostnet",
                        "CCodeIND2of5_S3",
                        "Arial"]

var barcodeFidelityNames = ["Standard","High - Strict Barcode Fonts"]

var barcodeNames = ["Code 39","Industrial 2 of 5","POSTNET"]

var barcodeNamesFull = ["Code 39",
                        "Code 39 ASCII",
                        "Code 128 Auto",
                        "Code 128 A",
                        "Code 128 B",
                        "Code 128 C",
                        "UCCEAN (GS1 128)",
                        "GS1 Databar 14",
                        "Code 93",
                        "Codabar",
                        "EAN 13",
                        "EAN 8",
                        "UPCA",
                        "UPCE",
                        "EXT2",
                        "EXT5",
                        "I2of5",
                        "ITF14",
                        "Industrial 2 of 5",
                        "Modified Plessy",
                        "POSTNET"]

var postnetFontNames = ["CCodeIPostnet",
                       "Arial"]

var bearersBarTypes = ["Top/Bottom",
                       "Rectangle"]

var mpFontNames = ["CCodeMSI_S1",
                       "CCodeMSI_S2",
                       "CCodeMSI_S3",
                       "CCodeMSI_S4",
                       "CCodeMSI_S5",
                       "CCodeMSI_S6",
                       "CCodeMSI_S7",
                       "Arial"]

var ind2of5FontNames = ["CCodeIND2of5_S1",
                       "CCodeIND2of5_S2",
                       "CCodeIND2of5_S3",
                       "CCodeIND2of5_S4",
                       "CCodeIND2of5_S5",
                       "CCodeIND2of5_S6",
                       "CCodeIND2of5_S7",
                       "Arial"]

var i2of5FontNames = ["CCodeI2of5_S1",
                       "CCodeI2of5_S2",
                       "CCodeI2of5_S3",
                       "CCodeI2of5_S4",
                       "CCodeI2of5_S5",
                       "CCodeI2of5_S6",
                       "CCodeI2of5_S7",
                       "CCodeI2of5_HS3",
                       "Arial"]

var itf14FontNames = ["CCodeITF_S1",
                       "CCodeITF_S2",
                       "CCodeITF_S3",
                       "CCodeITF_S4",
                       "CCodeITF_S5",
                       "CCodeITF_S6",
                       "CCodeITF_S7",
                       "Arial"]

var gs1databar14FontNames = ["CCodeGS1D_S1",
                       "CCodeGS1D_S2",
                       "CCodeGS1D_S3",
                       "CCodeGS1D_S4",
                       "CCodeGS1D_S5",
                       "CCodeGS1D_S6",
                       "CCodeGS1D_S7",
                       "CCodeGS1DTR",
                       //"CCodeGS1DEST",
                       //"CCodeGS1DST",
                       //"CCodeGS1DSTO",
                       "Arial"]

var upceanFontNames = ["CCodeUPCEAN_S1",
                       "CCodeUPCEAN_S2",
                       "CCodeUPCEAN_S3",
                       "CCodeUPCEAN_S4",
                       "CCodeUPCEAN_S5",
                       "CCodeUPCEAN_S6",
                       "CCodeUPCEAN_S7",
                       "CCodeUPCEAN_HRBS1",
                       "CCodeUPCEAN_HRBS2",
                       "CCodeUPCEAN_HRBS3",
                       //"CCodeUPCEAN_HRBS3X",
                       //"CCodeUPCEAN_HRBS3Y",
                       //"CCodeUPCEAN_HRBS3Z",
                       "CCodeUPCEAN_HRBS4",
                       "CCodeUPCEAN_HRBS5",
                       "CCodeUPCEAN_HRBS6",
                       "CCodeUPCEAN_HRBS7",
                       "CCodeUPCEAN_HRTS1",
                       "CCodeUPCEAN_HRTS2",
                       "CCodeUPCEAN_HRTS3",
                       
                       "CCodeUPCEANA_HRBS1",
                       "CCodeUPCEANA_HRBS2",
                       "CCodeUPCEANA_HRBS3",
                       "CCodeUPCEANA_HRBS4",
                       "CCodeUPCEANA_HRBS5",
                       "CCodeUPCEANA_HRBS6",
                       "CCodeUPCEANA_HRBS7",
                       "CCodeUPCEANA_HRTS1",
                       "CCodeUPCEANA_HRTS2",
                       "CCodeUPCEANA_HRTS3",
                       
                       "CCodeUPCEANB_HRBS1",
                       "CCodeUPCEANB_HRBS2",
                       "CCodeUPCEANB_HRBS3",
                       "CCodeUPCEANB_HRBS4",
                       "CCodeUPCEANB_HRBS5",
                       "CCodeUPCEANB_HRBS6",
                       "CCodeUPCEANB_HRBS7",
                       "CCodeUPCEANB_HRTS1",
                       "CCodeUPCEANB_HRTS2",
                       "CCodeUPCEANB_HRTS3",
                       "Arial"]

var codabarFontNames = ["CCodeCodabar_S1",
                       "CCodeCodabar_S2",
                       "CCodeCodabar_S3",
                       "CCodeCodabar_S4",
                       "CCodeCodabar_S5",
                       "CCodeCodabar_S6",
                       "CCodeCodabar_S7",
                       "Arial"]

var code39FontNames = ["CCode39_S1",
                       "CCode39_S2",
                       "CCode39_S3",
                       "CCode39_S4",
                       "CCode39_S5",
                       "CCode39_S6",
                       "CCode39_S7",
                       "CCode39_HS3",
                       "Arial"]

var code93FontNames = ["CCode93_S1",
                       "CCode93_S2",
                       "CCode93_S3",
                       "CCode93_S4",
                       "CCode93_S5",
                       "CCode93_S6",
                       "CCode93_S7",
                       "CCode93_HS3",
                       "Arial"]

var code128FontNames = ["CCode128_S1",
                       "CCode128_S2",
                       "CCode128_S3",
                       "CCode128_S4",
                       "CCode128_S5",
                       "CCode128_S6",
                       "CCode128_S7",
                       "CCode128B_HS3",
                       "Arial"]


var scaleValues = ["Fit","Fill"]

var measurementUnits = ["Inches","Centimeters"]

var orientation = ["Portrait","Landscape"]

var propertiesHeight = 400.0
var propertiesHeightTall = 450.0

var timeElapsedX = 0.0

var appType = "N" //B - B&L or N - nodef

var paddingTypes = [
    "No Padding",
    "Pad Zeros",
    "Pad Spaces",
    "Custom Padding"
]

var stepOperationTypes = [
    "Increment",
    "Decrement"
]

var counterTypes = [
    "Counter: 01",
    "Counter: 02",
    "Counter: 03",
    "Counter: 04",
    "Counter: 05"
]

var textTypes = [
    "Enter from Keyboard",
    "Contact: givenName",
    "Contact: middleName",
    "Contact: familyName",
    "Contact: namePrefix",
    //"Contact: previousFamilyName",
    "Contact: nameSuffix",
    //"Contact: nickname",
    "Contact: phoneNumber",
    "Contact: emailAddress",
    
    "Contact: street",
    "Contact: city",
    "Contact: state",
    "Contact: postalCode",
    "Contact: country",
    
    "Contact: jobTitle",
    "Contact: departmentName",
    "Contact: organizationName",

    //"Contact: work street",
    //"Contact: work city",
    //"Contact: work state",
    //"Contact: work postalCode",
    //"Contact: work country",
    
    //"Contact: school street",
    //"Contact: school city",
    //"Contact: school state",
    //"Contact: school postalCode",
    //"Contact: school country"

    //home work school other
    //"Contact: isoCountryCode",
    //"Contact: subAdministrativeArea",
    //"Contact: subLocality"
    "Counter: 01",
    "Counter: 02",
    "Counter: 03",
    "Counter: 04",
    "Counter: 05",
    
    "CSV Column: 01",
    "CSV Column: 02",
    "CSV Column: 03",
    "CSV Column: 04",
    "CSV Column: 05",
    "CSV Column: 06",
    "CSV Column: 07",
    "CSV Column: 08",
    "CSV Column: 09",
    "CSV Column: 10"
]

var barcodeInputTypes = [
    "Enter from Keyboard",
    //"Contact: givenName",
    //"Contact: middleName",
    //"Contact: familyName",
    //"Contact: namePrefix",
    //"Contact: nameSuffix",
    //"Contact: phoneNumber",
    //"Contact: emailAddress",
    
    //"Contact: street",
    //"Contact: city",
    //"Contact: state",
    //"Contact: postalCode",
    //"Contact: country",
    
    //"Contact: jobTitle",
    //"Contact: departmentName",
    //"Contact: organizationName",

    "Counter: 01",
    "Counter: 02",
    "Counter: 03",
    "Counter: 04",
    "Counter: 05",
    
    "CSV Column: 01",
    "CSV Column: 02",
    "CSV Column: 03",
    "CSV Column: 04",
    "CSV Column: 05",
    "CSV Column: 06",
    "CSV Column: 07",
    "CSV Column: 08",
    "CSV Column: 09",
    "CSV Column: 10"
]

/*
"Academy Engraved LET Plain:1.0",
"Al Nile",
"Al Nile Bold",
"American Typewriter",
"American Typewriter Bold",
"American Typewriter Condensed",
"American Typewriter Condensed Bold",
"American Typewriter Condensed Light",
"American Typewriter Light",
"American Typewriter Semibold",
"Apple Color Emoji",
"Apple SD Gothic Neo Bold",
"Apple SD Gothic Neo Light",
"Apple SD Gothic Neo Medium",
"Apple SD Gothic Neo Regular",
"Apple SD Gothic Neo SemiBold",
"Apple SD Gothic Neo Thin",
"Apple SD Gothic Neo UltraLight",
"Apple Symbols",
"Arial",
"Arial Bold",
"Arial Bold Italic",
"Arial Hebrew",
"Arial Hebrew Bold",
"Arial Hebrew Light",
"Arial Italic",
"Arial Rounded MT Bold",
"Avenir Black",
"Avenir Black Oblique",
"Avenir Book",
"Avenir Book Oblique",
"Avenir Heavy",
"Avenir Heavy Oblique",
"Avenir Light",
"Avenir Light Oblique",
"Avenir Medium",
"Avenir Medium Oblique",
"Avenir Next Bold",
"Avenir Next Bold Italic",
"Avenir Next Condensed Bold",
"Avenir Next Condensed Bold Italic",
"Avenir Next Condensed Demi Bold",
"Avenir Next Condensed Demi Bold Italic",
"Avenir Next Condensed Heavy",
"Avenir Next Condensed Heavy Italic",
"Avenir Next Condensed Italic",
"Avenir Next Condensed Medium",
"Avenir Next Condensed Medium Italic",
"Avenir Next Condensed Regular",
"Avenir Next Condensed Ultra Light",
"Avenir Next Condensed Ultra Light Italic",
"Avenir Next Demi Bold",
"Avenir Next Demi Bold Italic",
"Avenir Next Heavy",
"Avenir Next Heavy Italic",
"Avenir Next Italic",
"Avenir Next Medium",
"Avenir Next Medium Italic",
"Avenir Next Regular",
"Avenir Next Ultra Light",
"Avenir Next Ultra Light Italic",
"Avenir Oblique",
"Avenir Roman",
"Baskerville",
"Baskerville Bold",
"Baskerville Bold Italic",
"Baskerville Italic",
"Baskerville SemiBold",
"Baskerville SemiBold Italic",
"Bodoni 72 Bold",
"Bodoni 72 Book",
"Bodoni 72 Book Italic",
"Bodoni 72 Oldstyle Bold",
"Bodoni 72 Oldstyle Book",
"Bodoni 72 Oldstyle Book Italic",
"Bodoni 72 Smallcaps Book",
"Bodoni Ornaments",
"Bradley Hand Bold",
"Chalkboard SE Bold",
"Chalkboard SE Light",
"Chalkboard SE Regular",
"Chalkduster",
"Charter Black",
"Charter Black Italic",
"Charter Bold",
"Charter Bold Italic",
"Charter Italic",
"Charter Roman",
"Cochin",
"Cochin Bold",
"Cochin Bold Italic",
"Cochin Italic",
"Copperplate",
"Copperplate Bold",
"Copperplate Light",
"Courier",
"Courier Bold",
"Courier Bold Oblique",
"Courier New",
"Courier New Bold",
"Courier New Bold Italic",
"Courier New Italic",
"Courier Oblique",
"DIN Alternate Bold",
"DIN Condensed Bold",
"Damascus Bold",
"Damascus Light",
"Damascus Medium",
"Damascus Regular",
"Damascus Semi Bold",
"Devanagari Sangam MN",
"Devanagari Sangam MN Bold",
"Didot",
"Didot Bold",
"Didot Italic",
"Euphemia UCAS",
"Euphemia UCAS Bold",
"Euphemia UCAS Italic",
"Farah Regular",
"Futura Bold",
"Futura Condensed ExtraBold",
"Futura Condensed Medium",
"Futura Medium",
"Futura Medium Italic",
"Galvji",
"Galvji Bold",
"Geeza Pro Bold",
"Geeza Pro Regular",
"Georgia",
"Georgia Bold",
"Georgia Bold Italic",
"Georgia Italic",
"Gill Sans",
"Gill Sans Bold",
"Gill Sans Bold Italic",
"Gill Sans Italic",
"Gill Sans Light",
"Gill Sans Light Italic",
"Gill Sans SemiBold",
"Gill Sans SemiBold Italic",
"Gill Sans UltraBold",
"Helvetica",
"Helvetica Bold",
"Helvetica Bold Oblique",
"Helvetica Light",
"Helvetica Light Oblique",
"Helvetica Neue",
"Helvetica Neue Bold",
"Helvetica Neue Bold Italic",
"Helvetica Neue Condensed Black",
"Helvetica Neue Condensed Bold",
"Helvetica Neue Italic",
"Helvetica Neue Light",
"Helvetica Neue Light Italic",
"Helvetica Neue Medium",
"Helvetica Neue Medium Italic",
"Helvetica Neue Thin",
"Helvetica Neue Thin Italic",
"Helvetica Neue UltraLight",
"Helvetica Neue UltraLight Italic",
"Helvetica Oblique",
"Hiragino Maru Gothic ProN W4",
"Hiragino Mincho ProN W3",
"Hiragino Mincho ProN W6",
"Hiragino Sans W3",
"Hiragino Sans W6",
"Hiragino Sans W7",
"Hoefler Text",
"Hoefler Text Black",
"Hoefler Text Black Italic",
"Hoefler Text Italic",
"Kailasa Bold",
"Kailasa Regular",
"Kannada Sangam MN",
"Kannada Sangam MN Bold",
"Kefa Regular",
"Khmer Sangam MN",
"Kohinoor Bangla",
"Kohinoor Bangla Light",
"Kohinoor Bangla Semibold",
"Kohinoor Devanagari Light",
"Kohinoor Devanagari Regular",
"Kohinoor Devanagari Semibold",
"Kohinoor Gujarati Bold",
"Kohinoor Gujarati Light",
"Kohinoor Gujarati Regular",
"Kohinoor Telugu",
"Kohinoor Telugu Light",
"Kohinoor Telugu Medium",
"Lao Sangam MN",
"Malayalam Sangam MN",
"Malayalam Sangam MN Bold",
"Marker Felt Thin",
"Marker Felt Wide",
"Menlo Bold",
"Menlo Bold Italic",
"Menlo Italic",
"Menlo Regular",
"Mishafi Regular",
"Myanmar Sangam MN",
"Myanmar Sangam MN Bold",
"Noteworthy Bold",
"Noteworthy Light",
"Noto Nastaliq Urdu",
"Noto Nastaliq Urdu Bold",
"Noto Sans Kannada Bold",
"Noto Sans Kannada Light",
"Noto Sans Kannada Regular",
"Noto Sans Myanmar Bold",
"Noto Sans Myanmar Light",
"Noto Sans Myanmar Regular",
"Noto Sans Oriya",
"Noto Sans Oriya Bold",
"Optima Bold",
"Optima Bold Italic",
"Optima ExtraBlack",
"Optima Italic",
"Optima Regular",
"Palatino",
"Palatino Bold",
"Palatino Bold Italic",
"Palatino Italic",
"Papyrus",
"Papyrus Condensed",
"Party LET Plain",
"PingFang HK Light",
"PingFang HK Medium",
"PingFang HK Regular",
"PingFang HK Semibold",
"PingFang HK Thin",
"PingFang HK Ultralight",
"PingFang SC Light",
"PingFang SC Medium",
"PingFang SC Regular",
"PingFang SC Semibold",
"PingFang SC Thin",
"PingFang SC Ultralight",
"PingFang TC Light",
"PingFang TC Medium",
"PingFang TC Regular",
"PingFang TC Semibold",
"PingFang TC Thin",
"PingFang TC Ultralight",
"Plantagenet Cherokee",
"Rockwell",
"Rockwell Bold",
"Rockwell Bold Italic",
"Rockwell Italic",
"Savoye LET Plain:1.0",
"Sinhala Sangam MN",
"Sinhala Sangam MN Bold",
"Snell Roundhand",
"Snell Roundhand Black",
"Snell Roundhand Bold",
"Symbol",
"Tamil Sangam MN",
"Tamil Sangam MN Bold",
"Thonburi",
"Thonburi Bold",
"Thonburi Light",
"Times New Roman",
"Times New Roman Bold",
"Times New Roman Bold Italic",
"Times New Roman Italic",
"Trebuchet MS",
"Trebuchet MS Bold",
"Trebuchet MS Bold Italic",
"Trebuchet MS Italic",
"Verdana",
"Verdana Bold",
"Verdana Bold Italic",
"Verdana Italic",
"Zapf Dingbats",
"Zapfino",
 */
