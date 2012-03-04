require 'formula'

class MemcachedPhp < Formula
  homepage 'http://pecl.php.net/package/memcached'
  url 'http://pecl.php.net/get/memcached-2.0.1.tgz'
  md5 'f81a5261be1c9848ed5c071a4ebe5e05'

  depends_on 'libmemcached'

  def install
    Dir.chdir "memcached-#{version}" do
      system "phpize"
      system "./configure", "--prefix=#{prefix}",
                            "--with-libmemcached-dir=#{Formula.factory('libmemcached').prefix}"
      system "make"
      prefix.install 'modules/memcached.so'
    end
  end

  def caveats; <<-EOS.undent
    To finish installing memcached-php:
      * Add the following line to #{etc}/php.ini:
        extension="#{prefix}/memcached.so"
      * Restart your webserver.
      * Write a PHP page that calls "phpinfo();"
      * Load it in a browser and look for the info on the memcached module.
      * If you see it, you have been successful!
    EOS
  end
end
