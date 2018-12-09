#include <iostream>
#include <vector>

// 2 3 0 3 (10 11 12) 1 1 0 1 (99) (2) (1 1 2)

/*
A, which has 2 child nodes (B, C) and 3 metadata entries (1, 1, 2).
B, which has 0 child nodes and 3 metadata entries (10, 11, 12).
C, which has 1 child node (D) and 1 metadata entry (2).
D, which has 0 child nodes and 1 metadata entry (99).

Node C has one metadata entry, 2. Because node C has only one child node,
2 references a child node which does not exist, and so the value of node C
is 0.
Node A has three metadata entries: 1, 1, and 2. The 1 references node A's
first child node, B, and the 2 references node A's second child node, C.
Because node B has a value of 33 and node C has a value of 0, the value of
/node A is 33+33+0=66.
*/

struct Node {
        std::vector<Node> child_nodes;
        std::vector<int> child_nodes_int;
        std::vector<int> metadata;
};

void input_func(std::vector<Node> &d, int &n) {
    d.push_back(Node());
    int n_ch_n, n_meta, input;

    std::cin >> n_ch_n >> n_meta;
    //std::cout << "Input " << n_ch_n << "|" << n_meta << std::endl;

    //std::cout << "\tCheck for " << char(n+'A') << "|" << n << std::endl;

    int x = n;
    for (int j = 0; j < n_ch_n; j++) {
        n++;
        input_func(d, n);
        d[x].child_nodes.push_back(d[n]);
        d[x].child_nodes_int.push_back(n);
    }

    //std::cout << "\tCheck meta for " << char(n+'A') << std::endl;

    for (int j = 0; j < n_meta; j++) {
        std::cin >> input;
        d[x].metadata.push_back(input);
    }

    //std::cout << "--> End of " << char(x+'A') << std::endl;
};

void count_node_value(std::vector<Node> d, int n, int &sum) {
    //for(int x : d[n].metadata) std::cout << x << " ";
    //std::cout << std::endl;
    int x;
    for(int meta_entry : d[n].metadata) {
        x = d[n].child_nodes_int[meta_entry];

        if(d[x].child_nodes.size() == 0) {
            for(int z : d[x].metadata) {
                sum += z;
                std::cout << "\t" << z << "|" << sum << std::endl;
            }
        } else {
            count_node_value(d, x, sum);
        }
    }
}

int main () {
    std::vector<Node> data;

    int input, i = 0;
    input_func(data, i);

    //std::cout << "Check after input" << std::endl;
    /*
    for(int i = 0; i < data.size(); i++) {
        std::cout << i << "|\t" ;
        for(int j = 0; j < data[i].metadata.size(); j++) {
            std::cout << data[i].metadata[j] << " ";
        }
        std::cout << std::endl;
    }
    */
    int metadata_sum = 0;
    for(int i = 0; i < data.size(); i++) {
        for(int j = 0; j < data[i].metadata.size(); j++) {
            metadata_sum += data[i].metadata[j];
        }
    }
    std::cout << metadata_sum << std::endl;

    int sum = 0;
    count_node_value(data, 0, sum);
    std::cout << sum << std::endl;
}