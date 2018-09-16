let g:quickrun_config = {
      \"_" : {
      \"hook/close_unite_quickfix/enable_hook_loaded": 1,
      \"hook/close_quickfix/enable_failure": 1,
      \"hook/close_quickfix/enable_exit": 1,
      \"hook/close_buffer/enable_failure": 1,
      \"hook/close_buffer/enable_empty_data": 1,
      \"outputter/buffer/split": ":botright 10",
      \"hook/time/enable": '1',
      \"runner": "vimproc",
      \"runner/vimproc/updatetime": 40,
      \}
      \}
nmap <Leader>r <Plug>(quickrun)
