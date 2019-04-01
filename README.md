# Fast.ai Stuff

## Toy Web App

To run use

    $ python app.py

and

    $ ngrok http 5000

## Running on a remote server

Running the notebook on a remote server with a GPU via another server
that gives access to the GPU server. The problem is that the machine
with the GPU doesn't have any ports that can be seen from the outside
other than SSH. First setup port forwarding

    $ ssh intermediate-machine
    $ ssh -N -L intermediate-machine:8888:localhost:8888 gpu-machine

Start up the notebook

    $ ssh intermediate-machine
    $ ssh gpu-machine
    $ cd .../fastai-nix-install
    $ nix-shell --pure
    [nix-shell]$ cd ...
    [nix-shell]$ jupyter notebook --no-browser --NotebookApp.allow_remote_access=True

The `allow_remote_access` is required otherwise you get a 403. Copy
the token and you should be able to view the notebooks from
`http://intermediate-machine:8888/?token=<token>`.
