# Ed's dotfiles

Yes, these are my dotfiles. Well some of them... perhaps more will arrive in
the future.

The important part, of my own devising, is the Ctags+Cscope setup, to allow
easily creating/removing tags for new source trees and loading them into Vim.
That is described down below.

# Installation

```
git clone https://github.com/bswinnerton/dotfiles ~/.dotfiles
cd ~/.dotfiles
./install
```

# Components

- **`bin/`**: Anything in bin/ will be added to your `$PATH` and be made available
  to execute anywhere in your shell.
- **`topic/*.bash`**: Any files ending in `.bash` get loaded into your
  environment.
- **`topic/*path.bash`**: Any files ending in `path.bash` are loaded first and are
  expected to prepend/append `$PATH` or similar.
- **`topic/*.symlink`**: Any files ending in `*.symlink` get symlinked into your
  $HOME. This is so you can keep all of those versioned in your dotfiles but
  still keep those autoloaded files in your home directory. These get symlinked
  in when you run ./install.
- **`topic/install.sh`**: Any file named `install.sh` is automatically loaded when
  you call `./install`.

# Credits/Thanks to

The layout of the files here (I.e. topical subdirs, with the .symlink/.sh file
extension based method of setup) is based on
[@holman's dotfiles](https://github.com/holman/dotfiles).

The install script is largely re-used from
[@bswinnerton's dotfiles](https://github.com/bswinnerton/dotfiles).

# The main event: Controlling ctags+cscope indexing

This bit started because I was trying to index an entire Android platform
source code tree (AKA Android Open Source Project or AOSP). After trialling
several IDEs which provide "Jump to declaration" and "Find usages" type
navigation, I found that that they either died under the sheer volume of code,
didn't support all languages types needed (That's right, we do Java AND C/C++
here) or took a long time. As in several days long.

Eventually Ctags, Cscope and Vim were chosen because:
- Despite the names, Ctags and Cscope will index the required programming
  languages, plus many more.
- It's quick. Vim loads quickly, the tags are built quickly (~5 minutes for the
  entire AOSP, using the subset of file types I need)
- Vim is obedient. It only rebuilds and reloads the tags when I tell it to.

So all was well. Except....

I wanted an easier way to add and remove any given source code tree that I need
to look through on my system to the Ctags and Cscope indexing, without having
to edit any config files.

To explain why this became a more pressing need: At some points I end up
working on multiple projects per day, and each project could involve, for
example, a different Linux kernel source tree.
When using the vim ctags commands to jump to a declaration, I soon found I was
jumping out of the kernel for the project I was looking at, over to the
declaration in a kernel tree for a different project.
Therefore I needed a way to temporarily enable or disable tags for different
sources, ideally without breaking the flow of concentration.

For larger source code bases, such as the AOSP as mentioned above, it is better
if the tags for that projects can be disabled, without simply deleting them and
re-building from scratch when needed again. This avoids having to wait 5-10
minutes to re-index all the same code every time.

To optimise the indexing of larger source code bases, the types of source files
indexed should be clearly set somewhere, and again, altered without too much
distraction. However I am only concerned about control of file types indexed on
a global basis (Across all source trees/projects).

Lastly, I also prefer that the tag files for all indexed source on my system be
stored in a centralised location, which is not included in my periodic backup
of all human generated effort on my computer.


I met these needs using the setup in this dotfiles repo, which for the tagging,
is based around two scripts and commands to invoke them from Vim.

## From the command line

Create tags from any source tree:

`tags_gen.sh </path/to/source_dir>`

E.g.

`tags_gen.sh .`

`tags_gen.sh ~/projects/acme_corp/teleport-o-matic/bsp/linux-4.9/`

After the script has run, the tags for `<source_dir>` will have been created in
`~/not_backed_up/tags_cscope_databases/<source_dir>/`

In the `tags_cscope_databases/<source_dir>/` directory you will find:

- `cscope.files`: A list of all source files tagged. Used for the tagging
  process, but also good for checking things are working properly.
- `tags`: The Ctags index file
- `cscope.out`: The Cscope index file
- `src_dir_link`: A symbolic link to the full path of `<source_dir>`. I added
  this because sometimes I couldn't remember what `<source_dir>` was indexing
  (For instance in the second tags_gen.sh example above, `<source_dir>` would
  be named "linux-4.9" which could be any project). Looking at the path
  which the link points to makes it clear what these tags are for.

As long as you remember that all tags go into the `tags_cscope_databases/`
directory, keeping them under control becomes easy.

### Controlling source file types tagged

Edit the list in: `~/not_backed_up/tags_cscope_databases/file_extensions_to_tag.txt`

### Disable/re-enable tags

To disable tags for a source tree, simply move `<source_dir>` out of
`tags_cscope_databases/`

E.g.


```
mkdir ~/not_backed_up/tags_cscope_databases_unused_currently/
mv ~/not_backed_up/tags_cscope_databases/<source_dir> ~/not_backed_up/tags_cscope_databases_unused_currently/
```

To re-enable, move `<source_dir>` back again.

In order for the moving of `<source_dir>` in or out to take effect, the tags must
be rebuilt.

### Rebuild tags

Run:

`tags_update.sh`

## From within vim

### Load tags

`\lt`

(In my .vimrc I have Vim load tags on startup, as it is a fairly instant
operation)

### Rebuild tags

`\ut`

If you have a lot of source tagged, this will keep Vim busy for a while, so I
find it's best to rebuild the tags on the command line in order to continue
editing/browsing source in the meantime.


# Reminders to myself on using my vim setup

TBD.

