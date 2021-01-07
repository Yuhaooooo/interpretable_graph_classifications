import pickle
from torch.utils.data import Dataset

from dfscode.dfs_wrapper import get_min_dfscode
from datasets.preprocess import dfscode_to_tensor

def load_dfscode_tensor(tensor_path, graph_id):
    with open(tensor_path + 'graph' + str(graph_id) + '.dat', 'rb') as f:
            dfscode_tensors = pickle.load(f)
    return dfscode_tensors

class Graph_DFS_code_from_file(Dataset):
    """
    Dataset for reading graphs from files and returning matrices
    corresponding to dfs code entries
    :param args: Args object
    :param graph_list: List of graph indices to be included in the dataset
    :param feature_map: feature_map for the dataset generated by the mapping
    """

    def __init__(self, args, graph_list, feature_map):
        # Path to folder containing dataset
        self.dataset_path = args.current_processed_dataset_path
        self.graph_list = graph_list
        self.feature_map = feature_map
        self.temp_path = args.current_temp_path

        self.max_edges = feature_map['max_edges']
        max_nodes, len_node_vec, len_edge_vec = feature_map['max_nodes'], len(
            feature_map['node_forward']) + 1, len(feature_map['edge_forward']) + 1
        self.feature_len = 2 * (max_nodes + 1) + 2 * \
            len_node_vec + len_edge_vec

    def __len__(self):
        return len(self.graph_list)

    def __getitem__(self, idx):
        graph_id = self.graph_list[idx][0]
        graph_label = self.graph_list[idx][1]

        dfscode_tensors = load_dfscode_tensor(self.dataset_path, graph_id)

        # print('data.py: graph_id: ', graph_id)
        # print('data.py: dfscode_tensors: ', dfscode_tensors)

        return dfscode_tensors, graph_label


class Graph_DFS_code(Dataset):
    """
    Mainly for testing purposes
    Dataset for returning matrices corresponding to dfs code entries
    :param args: Args object
    :param graph_list: List of graph indices to be included in the dataset
    :param feature_map: feature_map for the dataset generated by the mapping
    """

    def __init__(self, args, graph_list, feature_map):
        # Path to folder containing dataset
        self.graph_list = graph_list
        self.feature_map = feature_map
        self.temp_path = args.current_temp_path

        self.max_edges = feature_map['max_edges']
        max_nodes, len_node_vec, len_edge_vec = feature_map['max_nodes'], len(
            feature_map['node_forward']) + 1, len(feature_map['edge_forward']) + 1
        self.feature_len = 2 * (max_nodes + 1) + 2 * \
            len_node_vec + len_edge_vec

    def __len__(self):
        return len(self.graph_list)

    def __getitem__(self, idx):
        G = self.graph_list[idx]

        # Get DFS code matrix
        min_dfscode = get_min_dfscode(G, self.temp_path)
        print(min_dfscode)

        # dfscode tensors
        dfscode_tensors = dfscode_to_tensor(min_dfscode, self.feature_map)

        return dfscode_tensors
