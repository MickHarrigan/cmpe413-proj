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
tree.create_node("State Machine", sm, parent=0)
# - Cache Block
i += 1
cache = i
tree.create_node("Cache Block", cache, parent=0)
# - Hit/Miss Detector
i += 1
hmd = i
tree.create_node("Hit/Miss Detector", hmd, parent=0)
# - Output Enable (Data)
i += 1
oe_d = i
tree.create_node("Output Enable (Data)", oe_d, parent=0)
# - Output Enable (Address)
i += 1
oe_a = i
tree.create_node("Output Enable (Address)", oe_a, parent=0)
# - Registers
i += 1
reg = i
tree.create_node("Registers", reg, parent=0)


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