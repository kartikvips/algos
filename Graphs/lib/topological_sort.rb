require_relative 'graph'

# Implementing topological sort using both Khan's and Tarian's algorithms

def topological_sort(vertices)
    queue = Queue.new
    checker = []

    vertices.each do |v|
        checker << v if v.in_edges != 1
    end

    return [] if checker.length > 1
    

    vertices.each do |v|
        if v.in_edges.empty?
            queue.enq(v)
        end
    end   

    sorted = []
    
    until queue.empty?
       
        current = queue.pop
        sorted << current
        # p current.value
        current.out_edges.each do |edge|
            
            queue.enq(edge.to_vertex) if edge.to_vertex.in_edges.empty?
            
            edge.destroy!
        end
        vertices.delete(current)
    end
    sorted
end
