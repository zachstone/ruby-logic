# Logic gates for use in electronics simulation

class Source
  attr_reader :state, :outputs
  attr_writer :outputs

  @state = false
  @outputs = []

  def initialize(state: false)
    @state = !!state
    @outputs = []
  end

  def state=(x)
    @state = x
    @outputs.each { |output| output.trigger }
  end

  def update()
    @outputs.each { |output| output.trigger }
  end
end

class Node
  attr_reader :state, :inputs, :outputs
  attr_writer :inputs, :outputs

  @state = false
  @inputs = []
  @outputs = []
  @input_limit = 0

  def initialize(inputs: [], outputs: [])
    if !inputs.empty? && outputs.empty?
      set_inputs(inputs)
    end
    @inputs = inputs
    @outputs = outputs
  end

  def trigger()
    state_old = @state
    @state = logic

    if @state != state_old
      @outputs.each { |output| output.trigger }
    end
  end

  def logic()
    @inputs[0].state
  end

  def set_inputs(inputs)
    @inputs = inputs
    inputs.each { |input| input.outputs << self }
  end
end

class NotGate < Node
  def logic()
    !@inputs[0]
  end
end

class AndGate < Node
  def logic()
    @inputs[0].state && @inputs[1].state
  end
end

class NandGate < Node
  def logic()
    !(@inputs[0].state && @inputs[1].state)
  end
end

class OrGate < Node
  def logic()
    @inputs[0].state || @inputs[1].state
  end
end

class NorGate < Node
  def logic()
    !(@inputs[0].state || @inputs[1].state)
  end
end

class XorGate < Node
  def logic()
    @inputs[0].state != @inputs[1].state
  end
end

class XnorGate < Node
  def logic()
    @inputs[0].state == @inputs[1].state
  end
end

class Circuit
  attr_reader :logic_nodes, :inputs, :outputs

  @inputs = []
  @outputs = []
  @logic_nodes = []

  def initialize(inputs: [])
    @inputs = []
    inputs.each { |input| @inputs << Node.new(inputs: [input]) }
    @outputs = []
    @logic_nodes = []
  end

  def add_node(node)
    @logic_nodes << node
  end

  def update()

  end
end