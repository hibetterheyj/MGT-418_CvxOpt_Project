function G = adj2gephilab(filename, ADJ, nodes_name, threshold)
    % Copy right from:
    % https://ch.mathworks.com/matlabcentral/fileexchange/51146-adj2gephilab
    % Convert ana adjacency matrix of a graph to 2 spreadhseets csv files
    % one for the edge table and the other for node table.
    % The files _node.csv and _edge.csv have to be open 
    %in Gephi via Data Laboratory.
    % INPUTS:
    %           filename: string for the prefix name of the two files .csv
    %           ADJ: the adjacency matrix
    %           parameters: vector as properties of the node to use as
    %                              attributes of them.
    % OUTPUTS:
    %            two csv spreadsheet files: 
    %                       filename_node.csv
    %                       filename_edge.csv
    %             G = it returns the graph in matlab
    %
    % The two files must be open in Gephi via the Data Laboratory
    nodecsv = [filename, '_node.csv'];
    edgecsv = [filename, '_edge.csv'];
    if nargin < 4
        threshold = 1e-4;
    end
    ADJ(abs(ADJ) < threshold) = 0;
    figure;
    spy(ADJ);
    title('The Parameters Matrix');
    ADJ = ADJ - diag(diag(ADJ));
    n = size(ADJ, 1); % square adjacency matrix
    if nargin < 3
        nodes_name = ones(n,1); % all nodes have the same attributes
    end

    % Node Table:
    % header for node csv
    fidN = fopen(nodecsv, 'w', 'native', 'UTF-8'); % best format for gephi
    fprintf(fidN, '%s\n', 'Id,Label');
    % 
    for i = 1 : n
        fprintf(fidN, '%s\n', [num2str(i) ',' nodes_name{i}]);
    end
    fclose(fidN);

    % Edge Table
    EdgeL = conv_EdgeList(triu(ADJ));
    S = EdgeL(:, 1); % sources
    T = EdgeL(:, 2); % targets
    W = EdgeL(:, 3); % weights
    fidE = fopen(edgecsv, 'w', 'native', 'UTF-8');
    % header for edge csv
    fprintf(fidE, '%s\n','Source,Target,Weight');
    for i = 1 : length(S)
          fprintf(fidN, '%s\n', [num2str(S(i)) ',' num2str(T(i)) ',' num2str(W(i))]);
    end
    fclose(fidE);
    G = graph(ADJ, nodes_name);
    figure;
    plot(G);
end

function EdgeL = conv_EdgeList(adj)
    % convert adj matrix to edge list
    n = size(adj,1); % number of nodes
    edges = find(adj > 0); % indices of all edges
    n_e = length(edges);
    EdgeL = zeros(n_e, 3);
    for e = 1 : n_e
      [i, j] = ind2sub([n, n], edges(e)); % node indices of edge e  
      EdgeL(e,:)=[i, j, adj(i,j)];
    end
end