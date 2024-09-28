# Plan9 tools

## acme - acme launch script DONE
Launch an acme instance font & size are defined in the Nix derivation ( leaves room for globals sizes in the fitire defined at the flake level ).

## find (f) - wrapper for silver searcher DONE

## Write DONE
write data to a writeable file by id. Example:
`Write ctl cleartag`
or
`Write ctl cleartag -i 6`

## GetWinData DONE
Get all metadata for an acme window based on id

## GetAllWinIDs DONE
Get all acme window ids

## Tags+ DONE
clear tags then
write default tags to window based on directory or file.

## TagsAll DONE
run Tags+ for all windows


## Exec DONE
Run command, redirect all output to global +Messages window.

## Build DONE
runs `Write ctl put -i id` on all dirty files.
detect project type and build i.e.
nix => nix build

## Run DONE
runs Build in dir then run based on project type i.e.
nix => nix run

## Fmt DONE
call correct formatter on file or dir

## Git
Launch a text window, attach to event,
provide UI for git allow commit, staging, push, pull, branch
read from acme/$id/event to intercept plumber. May need to be made in a proper language not nushell. Maybe try crystal lang
Use external program - write in odin - libs needed, 9p + acme, copy the go libs