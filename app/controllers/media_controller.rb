class MediaController < ApplicationController
  
  def index
    @media = TagCategory.find_or_create_by_name("Media").tags.find(:all, :order => 'taggings_count DESC')
    @fandom_listing = {}
    @media.each do |medium|
      @fandom_listing[medium] = medium.tags.valid.find(:all, :limit => 5, :order => 'taggings_count DESC')
    end
    @groups = @media.length.even? ? @media.length / 2 : @media.length / 2 + 1
  end
  
  def show
    @medium = Tag.find(params[:id])
    @fandoms = @medium.tags.valid.find(:all, :order => :name).paginate(:page => params[:page])
  end
end
