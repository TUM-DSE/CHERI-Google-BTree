"""
    interface designed with love by Cristian Sandu <cristian.sandu@tum.de>
"""
from nicegui import ui

@ui.page('/')
def page_layout():
    ui.label('CONTENT')
    [ui.label(f'Line {i}') for i in range(100)]
    with ui.header(elevated=True).style('background-color: #3874c8').classes('items-center justify-between'):
        ui.label('DRAM Indexes Evaluation')

def interface()  