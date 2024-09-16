let g:context_filetype#filetypes = {
  \ 'html': [
    \   {
      \     'start' : '^\s*<script type="application/x-go">',
      \     'end' : '^\s*</script>',
      \     'filetype' : 'go',
      \   },
  \   {
    \     'start' : '^\s*<style>',
    \     'end' : '^\s*</style>',
    \     'filetype' : 'css',
    \   },
  \ ],
  \ 'vue': [],
  \}
