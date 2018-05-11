require './StubBindZone.rb'

params = {
  files_domainlist: './domains.list',
  public: './public/primary',
  ip: '195.78.38.1',
  ns1: 'master.km.ua',
  ns2: 'ns2.master.km.ua',
  date: "#{Time.new.strftime('%Y%m%d')}01",
  os: :linux # :frebsd or :linux

}


stub = StunBindZone.new(params)
stub.generate
