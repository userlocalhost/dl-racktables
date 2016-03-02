require 'json'

module DlRacktables
  class Output
    def self.success(opts)
      puts JSON.dump(opts.merge({
        'status': 'success',
      }))
    end
    def self.error(msg)
      puts JSON.dump({
        'status': 'error',
        'msg': msg,
      })
    end
  end
end
