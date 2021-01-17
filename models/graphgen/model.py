from baselines.dgmg.model import create_model as create_model_dgmg
from baselines.graph_rnn.model import create_model as create_model_graph_rnn
from graphgen.model import create_model as create_model_graphgen
from graphgen_cls.model import create_model as create_model_graphgen_cls


def create_model(args, feature_map):
    if args.note == 'GraphRNN':
        model = create_model_graph_rnn(args, feature_map)

    elif args.note == 'DFScodeRNN':
        model = create_model_graphgen(args, feature_map)

    elif 'DFScodeRNN_cls' in args.note:
        model = create_model_graphgen_cls(args, feature_map)

    elif args.note == 'DGMG':
        model = create_model_dgmg(args, feature_map)

    return model
