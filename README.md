# matrix

This is our [Matrix](https://matrix.org) chat platform deployment. It runs Synapse, because
as far as we can tell this is the only homeserver viable for organizational use (the others
do not have SSO / etc), and will likely be that way for the foreseeable future because Dendrite
targets individual users (as per the README) and Conduit is missing major other Matrix features.
