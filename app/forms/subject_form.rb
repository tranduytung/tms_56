class SubjectForm < Reform::Form
  include Reform::Form::ActiveModel
  include Reform::Form::ModelReflections

  model :subject, on: :subject
  
  property :content
  property :description
  
  validates :content, presence: true
  validates :description, presence: true

  collection :tasks, populate_if_empty: Task do
    property :content
    property :description
    validates :description, presence: true
    validates :content, presence: true
    property :_destroy, writeable: false
  end

  def save
    super do |attrs|
      to_be_removed = ->(i) {i[:_destroy] == "1"}
      if model.persisted?
        task_ids_to_rm = attrs[:tasks].select(&to_be_removed).map {|i| i[:id]}
        Task.destroy task_ids_to_rm
        tasks.reject! {|i| task_ids_to_rm.include? i.id}
        tasks.reject! {|i| i.content.blank?}
      else
        task_ids_to_rm = attrs[:tasks].select(&to_be_removed).map {|i| i[:_destroy]}
        tasks.reject! {|i| task_ids_to_rm.include? i._destroy}
        tasks.reject! {|i| i.content.blank?}
      end
    end

    super
  end
end
