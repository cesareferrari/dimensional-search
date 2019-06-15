class DimensionalSearch
  attr_reader :lvs, :width, :width_max, :arch, :arch_max, :se_dim, :se_max, :le_dim, :le_max, :location, :springs, :spring_options, :spring_datum_options, :sort

  def initialize(options)
    @lvs = options.fetch('lvs') if options['lvs']
    @width = options.fetch('width') if options['width']
    @width_max = options.fetch('width_max') if options['width_max']
    @location = options.fetch('location') if options['location']
    @arch = options.fetch('arch') if options['arch']
    @arch_max = options.fetch('arch_max') if options['arch_max']
    @se_dim = options.fetch('se_dim') if options['se_dim']
    @se_max = options.fetch('se_max') if options['se_max']
    @le_dim = options.fetch('le_dim') if options['le_dim']
    @le_max = options.fetch('le_max') if options['le_max']
    @sort = options.fetch('sort') if options['sort']
  end

  def width
    if width_max
      width_max.empty? ? @width : Range.new(@width, width_max)
    end
  end

  def arch
    if arch_max
      arch_max.empty? ? @arch : Range.new(@arch, arch_max)
    end
  end

  def se_dim
    if se_max
      se_max.empty? ? @se_dim : Range.new(@se_dim, se_max)
    end
  end

  def le_dim
    if le_max
      le_max.empty? ? @le_dim : Range.new(@le_dim, le_max)
    end
  end

  def sort
    if @sort
      @sort
    else
      'pn'
    end
  end

  def spring_options
    {
      'lvs' => lvs,
      'width' => width,
      'location' => location
    }.delete_if { |k, v| v.nil? || (v.empty? if v.respond_to?('empty?')) || v == 'unknown' }
  end

  def spring_datum_options
    {
      'arch' => arch,
      'se_dim' => se_dim,
      'le_dim' => le_dim,
    }.delete_if { |k, v| v.nil? || (v.empty? if v.respond_to?('empty?')) }
  end

  def springs
    if spring_datum_options.empty?
      if %w(pn width).include? sort
        TriangleSpring.where(spring_options).order(sort)
      else
        TriangleSpring.
          joins(:spring_datum).
          where(spring_options).order(sort)
      end
    else
      TriangleSpring.
        joins(:spring_datum).
        where(spring_options.merge(spring_data: spring_datum_options)).order(sort)
    end
  end
end
