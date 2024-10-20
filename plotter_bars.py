#!/usr/bin/env python3
import argparse, os, json
from src.plotters import *

import matplotlib.pyplot as plt
import seaborn as sns
import pandas as pd


def fetch_args():
    parser = argparse.ArgumentParser()
    parser.add_argument('-c', '--config', help='the configuration used for plots.',
                        type=str, default='configplot.json')
    parser.add_argument('-d', '--dir', help='the directory containing the dumbed data from the evaluator.',
                        type=str, default='./output')
    return parser.parse_args()

def read_config(filename: str) -> dict:
    return json.load(open(filename))

def read_data(path: str):
    data = [json.loads(x) for x in open(path).readlines()]
    return {
        x['thread']: {
            'mean': x['mean'],
            'var':  x['var']
        } for x in data
    }

def plot_results():
    sns.set_theme()

    for path, _, _ in os.walk(f'./output_nocapabilities/normal_benchmark'):
        if os.path.exists(f'{path}/config.json'):
            dsName = path.split('/')[-1]
            path_cap    = path.replace('output_nocapabilities', 'output_capabilities')

            # pfill_nocap = read_data(f'{path}/summary_dataset_performfill.txt')
            # pfill_cap   = read_data(f'{path_cap}/summary_dataset_performfill.txt')

            pfill_cap   = read_data(f'{path_cap}/summary_dataset_performquery.txt')
            pfill_nocap = read_data(f'{path}/summary_dataset_performquery.txt')

            # Sample data for demonstration
            latency = [pfill_nocap[2]['mean'], pfill_cap[2]['mean']]
            variance = [pfill_nocap[2]['var'], pfill_cap[2]['var']]
            data = pd.DataFrame({
                'Category': ['No-Capabilities', 'Capabilities'],
                'Latency': latency,
                'Variance': variance
            })

            # Create the barplot
            plt.figure(figsize=(5, 6))
            barplot = sns.barplot(
                x='Category', 
                y='Latency', 
                data=data, 
                palette='viridis', 
                ci=None
            )


            if dsName != 'cuckoo':
                # Add error bars
                for index, row in data.iterrows():
                    barplot.errorbar(
                        x=index, 
                        y=row['Latency'], 
                        yerr=row['Variance'], 
                        fmt='none', 
                        c='black', 
                        capsize=5
                    )

            hatches = ['/', '/', '|', '-']
            for bar, hatch in zip(barplot.patches, hatches):
                bar.set_hatch(hatch)
                
            right_bar_top = data['Latency'].iloc[1]
            left_bar_top  = data['Latency'].iloc[0]
            plt.plot([1-0.40, -0.40], [right_bar_top-0.1, right_bar_top-0.1], color='black', linestyle='--')

            plt.annotate(
                '', 
                xy=(-0.35, right_bar_top - 0.5), 
                xytext=(-0.35, left_bar_top + 0.5),
                arrowprops=dict(arrowstyle='<->', color='black', linestyle='--')
            )
            difference = (latency[1]-latency[0]) * 100 / latency[1]
            plt.text(-0.40, (right_bar_top - left_bar_top)/2 + left_bar_top ,
                     f'diff.: {difference: .2f}%', 
                ha='center', va='center', fontsize=12, color='black', rotation=90)
            # plt.plot([-0.40, -0.40], [right_bar_top - 0.5, left_bar_top + 0.5], color='black', linestyle='<->')

            # Customize the plot
            plt.title('Lower is better ↓')
            plt.xlabel('')
            plt.ylabel('Latency (ns.)')
            plt.savefig(f'{dsName}.png', bbox_inches='tight')
            plt.show()
            # # Create individual plots
            # for i in range(len(df)):
            #     plt.figure()
            #     sns.barplot(x='Category', y='Latency (ns.)', data=df.iloc[[i]], yerr=df['Variance'][i])
            #     plt.title(f'Plot {i+1}')
            #     plt.savefig(f'plot_{i+1}.png')
            #     plt.close()

            # print("Plots saved as separate files.")

def main():
    args   = fetch_args()
    config = read_config(filename=args.config)
    plot_results()

if __name__ == '__main__':
    main()
