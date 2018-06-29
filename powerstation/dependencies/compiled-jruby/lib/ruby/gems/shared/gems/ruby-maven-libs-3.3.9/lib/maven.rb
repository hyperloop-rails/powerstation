module Maven

  VERSION = '3.3.9'.freeze

  def self.exec( *args )
    if args.member?( '-Dverbose=true' ) || args.member?( '-Dverbose' ) || args.member?( '-X' )
      puts "mvn #{args.join(' ')}"
    end
    old_maven_home = ENV['M2_HOME']
    ENV['M2_HOME'] = home
    system "#{Maven.bin( 'mvn' )} #{args.join( ' ' )}"
  ensure
    ENV['M2_HOME'] = old_maven_home
  end

  def self.home
    @home ||= begin
                dir = File.dirname( File.expand_path( __FILE__ ) )
                File.expand_path( "#{dir}/../maven-home" )
              end
  end

  def self.bin( file = nil )
    if file
      File.join( path( 'bin' ), file )
    else
      path( 'bin' )
    end
  end

  def self.lib
    path( 'lib' )
  end

  def self.conf
    path( 'conf' )
  end

  def self.boot
    path( 'boot' )
  end
  
  private

  def self.path( name )
    File.join( home, name )
  end
end
