class StunBindZone

  def initialize(params)
    require 'erb'
    require 'fileutils'
    @file_domainlists = params[:files_domainlist]
    @public = params[:public]
    @ip = params[:ip]
    @ns1 = params[:ns1]
    @ns2 = params[:ns2]
    @date = params[:date]
    @os = params[:os]
  end

  def generate
    clear_domains_zones
    domains.each do |domain|
      @domain = domain
      File.write("#{@public}/#{domain}", ERB.new(File.read('./templates/domain.erb')).result(binding))
    end
    @domains = domains
    @path = @os == :freebsd ? 'primary/' : '/etc/bind/primary/'
    File.write("#{@public}/../named_zones.conf", ERB.new(File.read('./templates/named_zones.conf.erb')).result(binding))
  end

  private

  def domains
    File.readlines(@file_domainlists).map(&:strip).reject(&:empty?).uniq.sort
  end

  def clear_domains_zones
    FileUtils.rm_rf("#{@public}/.", secure: true)
  end
end
