# encoding: utf-8

class ElanTier

  attr_accessor :elan_document, :tier_id, :annotations

  def initialize(elan_document)
    @elan_document = elan_document
    @annotations = []
  end

  def self.from_xml(elan_document, xml_element)
    instance = ElanTier.new(elan_document)
    instance.tier_id = xml_element[:TIER_ID]
    # read annotations

    anno_els = xml_element.xpath('./ANNOTATION/ALIGNABLE_ANNOTATION')
    anno_els.each do |anno_el|

      min = elan_document.time_slots[anno_el[:TIME_SLOT_REF1]]
      max = elan_document.time_slots[anno_el[:TIME_SLOT_REF2]]
      val = anno_el.xpath('./ANNOTATION_VALUE').first.text

      instance.annotations << ElanAnnotation.new(instance, min, max, val)

    end

    instance
  end

end