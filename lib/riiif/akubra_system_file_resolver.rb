require 'digest'
require 'cgi'
module Riiif
  module AkubraSystemFileResolver
    #mattr_accessor :root, :base_path, :input_types

    #self.root = File.expand_path(File.join(File.dirname(__FILE__), '../..'))
    #self.base_path = File.join(root, 'spec/samples')
    #self.input_types = %W{png jpg tiff jp jp2}
    self.pathroot = "/usr/local/fedora/data/datastreamStore/"
    self.imagetype = "jp2"


    def self.find(id)
      Riiif::File.new(path(id))
    end

    def self.path(id)
      search = pattern(id)
      Dir.glob(search).first || raise(ImageNotFoundError, search)
    end

    def self.pattern(id)
      fullpid = "info:fedora/#{id}/#{imagetype}/#{imagetype}.0"
      md5 = Digest::MD5.new
      md5.update fullpid
      digest = md5.hexdigest
      directorystr = digest[0,2] + "/" + digest[2,2] + "/" +digest[4,1] + "/"
      filename = CGI.escape(fullpid)
      fullpath = pathroot + directorystr + filename
      fullpath	  
    end

  end
end
