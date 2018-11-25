cur = 0;
lines = []

nonprint = {
    0: "NUL",
    1: "STH",
    2: "STT",
    3: "ETX",
    4: "ETT",

    5: "ENQ",
    6: "ACK",
    7: "BEL",
    8: "BAK",
    9: "HT ",

    10: "LF ",
    11: "VT ",
    12: "FF ",
    13: "CR ",
    14: "SHO",

    15: "SHI",
    16: "DLE",
    17: "DC1",
    18: "DC2",
    19: "DC3",

    20: "DC4",
    21: "NAK",
    22: "IDL",
    23: "ETB",
    24: "CNC",

    25: "EME",
    26: "SUB",
    27: "ESC",
    28: "FSP",
    29: "GSP",

    30: "RSP",
    31: "USP",

    127: "DEL",
}

while cur < 128:
    a = nonprint[cur] if cur in nonprint else " " + str(chr(cur)) + " "
    l = "{} {}  {}  | ".format(
        str(cur).zfill(3),
        "".join(" %02x"%cur),
        a)
    cur += 1
    lines.append(l)

print("| " + "DEC HEX  SYM  | " * 4)
print("+-" + "--------------+-" * 4)
for i in range(32):
    print("| " + lines[i] + lines[i+32] + lines[i+64] + lines[i+96])


