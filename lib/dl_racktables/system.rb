require 'nokogiri'

module DLRacktables
  class System
    def who_operate_vm_lastly(vmid)
      resp = HTTP.get("index.php?page=search&last_page=object&last_tab=edit&q=#{vmid}")
    
      doc = Nokogiri::HTML(resp.body)
    
      if doc.title =~ /search results for/
        # meaning invalid vmid is specified
        return false
      end

      # get responsible team if it's specified
      team = ''
      if responsible_team = doc.xpath("//div[@class='portlet']//tr").find {|x| x.text =~ /b-10/}
        team = responsible_team.xpath("td//select//option[@selected]").text
      end

      # get person who update this object lastly
      person = doc.xpath("//table[@class='cooltable']//tr").map {|x| x.children[1].text}.last

      {team: team, person: person}
    end
  end
end
