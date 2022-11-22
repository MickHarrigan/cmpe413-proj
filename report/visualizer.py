from treelib import Node, Tree

tree = Tree()

i = 0

# top level chip node
chip = i
tree.create_node("Chip", chip)

# all main modules to the chip itself
# - State Machine
i += 1
sm = i
tree.create_node("State Machine", sm, parent=chip)
# - Cache Block
i += 1
cache = i
tree.create_node("Cache Block", cache, parent=chip)
# - Hit/Miss Detector
i += 1
hmd = i
tree.create_node("Hit/Miss Detector", hmd, parent=chip)
# - Output Enable (Data)
i += 1
oe_d = i
tree.create_node("Output Enable (Data)", oe_d, parent=chip)
# - Output Enable (Address)
i += 1
oe_a = i
tree.create_node("Output Enable (Address)", oe_a, parent=chip)
# - Registers
i += 1
reg = i
tree.create_node("Registers", reg, parent=chip)


# submodules section

# state machine submodules
# NOTE: Read hit, read miss, write hit, write miss


# cache submodules
# Valid block
i += 1
cacheValid = i
tree.create_node("Valid Tags", cacheValid, parent=cache)
# Tag block
i += 1
cacheTag = i
tree.create_node("2 Bit Row Tags", cacheTag, parent=cache)
# 4B x 4B Cache
i += 1
cacheBlock = i
tree.create_node("4x4 Byte Cells", cacheBlock, parent=cache)
# Decoder
i += 1
cacheDec = i
tree.create_node("Byte Decoder", cacheDec, parent=cache)


tree.show()

# tree 2 is the full coverage chip level design
tree2 = Tree()

i = 0
chip = i
tree2.create_node("Chip", chip)
i += 1
sm = i
tree2.create_node("State Machine", sm, parent=chip)
i += 20
cb = i
c4b = cb + 1
crd = c4b + 1
cc8 = crd + 1
cc1 = cc8 + 1
cbd = cc1 + 1
tree2.create_node("Cache Block", cb, parent=chip)
tree2.create_node("Cache Row Decoder", crd, parent=cb)
tree2.create_node("4x Cache 4 byte", c4b, parent=cb)
tree2.create_node("Cache Byte Decoder", cbd, parent=c4b)
tree2.create_node("Cache Cell 8", cc8, parent=c4b)
tree2.create_node("8x Cache Cell 1", cc1, parent=cc8)

i += 20
tb = i
td = tb + 1
# cc2
cc2 = td + 1
tree2.create_node("Tag Block", tb, parent=chip)
tree2.create_node("Tag Decoder", td, parent=tb)
tree2.create_node("4x Cache Cell 2", cc2, parent=tb)
i += 20
vceg = i
# vbd
vbd = vceg + 1
tree2.create_node("Valid Chip Enable Generator", vceg, parent=chip)
tree2.create_node("Valid Bit Decoder", vbd, parent=vceg)
i += 20
reg = i
# rwreg
rwreg = reg + 1
# cdreg
cdreg = rwreg + 1
# careg
careg = cdreg + 1
tree2.create_node("Registers", reg, parent=chip)
tree2.create_node("RD_WR Register", rwreg, parent=reg)
tree2.create_node("CPU Data Register", cdreg, parent=reg)
tree2.create_node("CPU Address Register", careg, parent=reg)
i += 20
oec = i
# cdoe
cdoe = oec + 1
# maoe
maoe = cdoe + 1
tree2.create_node("Output Enable Controllers", oec, parent=chip)
tree2.create_node("CPU Data Output Enable", cdoe, parent=oec)
tree2.create_node("Memory Address Output Enable", maoe, parent=oec)
i += 20
mux = i
# m21
m21 = mux + 1
tree2.create_node("Muxes", mux, parent=chip)
tree2.create_node("2 to 1 Mux", m21, parent=mux)
i += 20
cnt = i
# reg5
reg5 = cnt + 1
# add5
add5 = reg5 + 1
# buff5
buff5 = add5 + 1
tree2.create_node("5 Bit Counter", cnt, parent=chip)
tree2.create_node("5 Bit Register", reg5, parent=cnt)
tree2.create_node("5 Bit Adder", add5, parent=cnt)
tree2.create_node("5 Bit Buffer", buff5, parent=cnt)
i += 20
cmp = i
tree2.create_node("5 Bit Comparator", cmp, parent=chip)
i += 20
hm = i
# cmp2
cmp2 = hm + 1
tree2.create_node("Hit/Miss Detector", hm, parent=chip)
tree2.create_node("2 Bit Comparator", cmp2, parent=hm)


tree2.show()