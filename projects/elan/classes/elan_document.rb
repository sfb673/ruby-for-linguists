# encoding: utf-8

require 'nokogiri'

class ElanDocument

  attr_accessor :tiers
  attr_accessor :time_slots

  def initialize
    @tiers = []
    @time_slots = {}
  end

  def describe
    str = ""
    tiers.each do |tier|
      str << tier.tier_id << "\n" << ('-'*16) << "\n"
      tier.annotations.each do |ann|
        str << '  ' << ann.describe << "\n"
      end
    end
    str
  end

  def self.import_from_file(filename)
    instance = ElanDocument.new

    xmldoc = Nokogiri::XML::parse(File.open(filename))
    root = xmldoc.root

    # read TIME_SLOTS

    time_slot_els = root.xpath './TIME_ORDER/TIME_SLOT'
    time_slot_els.each do |time_slot_el|
      instance.time_slots[time_slot_el[:TIME_SLOT_ID]] = time_slot_el[:TIME_VALUE].to_i
    end

    tier_els = root.xpath './TIER'
    tier_els.each do |tier_el|
      # puts tier_el['TIER_ID']
      instance.tiers << ElanTier.from_xml(instance, tier_el)
    end

    instance
  end
end