#Run the formatter on the current file.
def main [] {
	let id = $env.winid
	let windata = (GetWinData --id $id | from json)
	Write --id $id ctl put
	match $windata {
  	{directory: true, name: $name} if ($name | str trim | append 'flake.nix' | str join "" | path exists) => {
			Exec nix fmt .
			GetAllWinIDs -e | from json | each {|it| Write --id $it.id ctl get} | ignore
    },
    {directory: false, name: $name} if ($name | path basename | str ends-with '.nix') => {
			Exec nix fmt $name
    	Write --id $id ctl get
    },
    _ => exit
  }
}
