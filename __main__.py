# from gui import interface
import argparse, json
from src.services import Benchmark

def fetch_args():
    parser = argparse.ArgumentParser()
    parser.add_argument('--webgui', help='start a webgui interface for the script.')
    parser.add_argument('-c', '--config', help='path to the configuration file.',
                        required=True, type=str)
    return parser.parse_args()

def read_config(filename: str) -> dict:
    return json.load(open(filename))

def main():
    args = fetch_args()
    if args.webgui: return None

    config = read_config(args.config)

    bmark = Benchmark()

if __name__ == '__main__':
    main()