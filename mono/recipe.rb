class Mono < FPM::Cookery::Recipe
  description 'Mono open source ECMA CLI, C# and .NET implementation.'

  name     'mono'
  version  "3.2.4-branch"
  homepage 'http://www.mono-project.com'
  source   'https://github.com/mono/mono', :submodule => ["external/ikvm", "external/Newtonsoft.Json", "external/aspnetwebstack", "external/cecil"], :with => :git, :branch => "mono-3.2.4-branch"
  section 'main'

  build_depends 'gettext', 'libtool', 'automake', 'make', 'gcc', 'autoconf'

  def build
    autogen :prefix => "/usr/local",
            :enable_parallel_mark => true
    
    make 'get-monolite-latest'

    make 'EXTERNAL_MCS' => "#{Dir.pwd}/mcs/class/lib/monolite/gmcs.exe"
  end

  def install
    make :install, 'DESTDIR' => destdir
  end

end
