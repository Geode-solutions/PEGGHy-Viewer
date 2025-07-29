# Standard library imports

# Third party imports
from opengeodeweb_viewer.vtkw_server import _Server, run_server

# Local application imports
from pegghy_viewer.rpc.protocols import VtkPEGGHyViewerView


class VtkPEGGHyViewerServer(_Server):
    def initialize(self):
        _Server.initialize(self)
        self.registerVtkWebProtocol(VtkPEGGHyViewerView())


def run_viewer():
    run_server(PEGGHyViewerServer)


if __name__ == "__main__":
    run_viewer()
