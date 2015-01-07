require_relative 'logic'


# This program implements a full adder using the logic library.

######################################################################
#                                                                    #
#                             FULL ADDER                             #
#       _____________                                                #
# a ---|             |-----+                                         #
#      | half_adder1 |     |  _____________                          #
# b ---|_____________|-+   +-|             |----------------- output #
#                      |     | half_adder2 |    _________            #
# c -------------------|-----|_____________|---|         |           #
#                      |                       | or_gate |--- output #
#                      +-----------------------|_________|           #
#                                                                    #
######################################################################


a = Source.new
b = Source.new
c = Source.new

half_adder1 = Circuit.new(inputs: [a, b])
half_adder1.add_node(AndGate.new(inputs: [half_adder1.inputs[0], half_adder1.inputs[1]]))
half_adder1.add_node(XorGate.new(inputs: [half_adder1.inputs[0], half_adder1.inputs[1]]))
half_adder1.outputs << half_adder1.logic_nodes[0]
half_adder1.outputs << half_adder1.logic_nodes[1]

half_adder2 = Circuit.new(inputs: [half_adder1.outputs[0], c])
half_adder2.add_node(AndGate.new(inputs: [half_adder2.inputs[0], half_adder2.inputs[1]]))
half_adder2.add_node(XorGate.new(inputs: [half_adder2.inputs[0], half_adder2.inputs[1]]))
half_adder2.outputs << half_adder2.logic_nodes[0]
half_adder2.outputs << half_adder2.logic_nodes[1]

or_gate = OrGate.new(inputs: [half_adder1.outputs[1], half_adder2.outputs[1]])

a.update
b.update
c.update

puts "#{a.state} + #{b.state} + #{c.state} = #{half_adder2.outputs[0].state} #{or_gate.state}"

a.state = true
puts "#{a.state} + #{b.state} + #{c.state} = #{half_adder2.outputs[0].state} #{or_gate.state}"

b.state = true
puts "#{a.state} + #{b.state} + #{c.state} = #{half_adder2.outputs[0].state} #{or_gate.state}"

c.state = true
puts "#{a.state} + #{b.state} + #{c.state} = #{half_adder2.outputs[0].state} #{or_gate.state}"