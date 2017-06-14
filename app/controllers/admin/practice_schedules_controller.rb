module Admin
  class PracticeSchedulesController < Admin::ApplicationController
    # To customize the behavior of this controller,
    # simply overwrite any of the RESTful actions. For example:
    #
    # def index
    #   super
    #   @resources = PracticeSchedule.all.paginate(10, params[:page])
    # end

    # Define a custom finder by overriding the `find_resource` method:
    # def find_resource(param)
    #   PracticeSchedule.find_by!(slug: param)
    # end

    # See https://administrate-docs.herokuapp.com/customizing_controller_actions
    # for more information
    def index
      search_term = params[:search].to_s.strip
      resources = Administrate::Search.new(resource_resolver, search_term).run
      order = Administrate::Order.new(:practice_date, :desc)
      resources = order.apply(resources)
      resources = resources.page(params[:page]).per(records_per_page)

      page = Administrate::Page::Collection.new(dashboard, order: order)

      render locals: {
        resources: resources,
        search_term: search_term,
        page: page,
      }
    end

    def show
      render locals: {
        page: Administrate::Page::Show.new(dashboard, requested_resource),
        practice_menu: requested_resource.practice_menu_sets.select("*").joins(:practice_content).select("*")
      }
    end

    def new
      category_set

      render locals: {
        page: Administrate::Page::Form.new(dashboard, resource_class.new),
      }
    end

    def create
      resource = resource_class.new(resource_params)

      begin
        ActiveRecord::Base.transaction do
          if resource.save

            practice_menu_set = practice_menu_set_params
            practice_menu_set_save(practice_menu_set, resource)

            redirect_to(
              [namespace, resource],
              notice: translate_with_resource("create.success"),
            )
          else
            render_create_err(dashboard, resource)
          end
        end

      rescue => e
        render_create_err(dashboard, resource)
      end
    end

    def edit
      edit_set

      render locals: {
        page: Administrate::Page::Form.new(dashboard, requested_resource),
        # practice_menu: requested_resource.practice_menu_sets.select("*").joins(:practice_content).select("practice_contents.*")
      }
    end

    def update
      begin
        ActiveRecord::Base.transaction do
          if requested_resource.update(resource_params)

            PracticeMenuSet.where(practice_schedule_id: params[:id]).destroy_all
            practice_menu_set_save(practice_menu_set_params, requested_resource)

            redirect_to(
              [namespace, requested_resource],
              notice: translate_with_resource("update.success"),
            )
          else
            render_update_err(dashboard, requested_resource)
          end
        end

      rescue => e
        render_update_err(dashboard, requested_resource)
      end
    end

    def category_select
        # pluckで敢えて配列にしています。
        @practice_content = PracticeContent.where(category_id: params[:category_id]).pluck(:practice_name, :id)

        # 初期値
        @practice_content.unshift(["-", ""])
        @index = params[:index];

        respond_to do |format|
            format.js
        end
    end

    def plactice_name_select
        @plactice_detail = PracticeContent.find(params[:content_id])
        @index = params[:index];

        respond_to do |format|
            format.js
        end
    end

    private
      def practice_menu_set_params
        params.permit(:time => [], :practice_content_id => [])
      end

      def practice_menu_set_save(practice_menu_set, resource)
        ActiveRecord::Base.transaction do
          1.upto(practice_menu_set[:time].size - 1) do |i|
              @practice_menu_set = PracticeMenuSet.new
              @practice_menu_set.practice_schedule_id = resource.id
              @practice_menu_set.practice_content_id = practice_menu_set[:practice_content_id][i]
              @practice_menu_set.order = i
              @practice_menu_set.time = practice_menu_set[:time][i]
              @practice_menu_set.save!
              
          end
        raise ActiveRecord::Rollback
        end
      end

      def render_create_err(dashboard, resource)
        category_set
        render :new, locals: {
          page: Administrate::Page::Form.new(dashboard, resource),
        }
      end

      def render_update_err(dashboard, resource)
        edit_set
        render :edit, locals: {
          page: Administrate::Page::Form.new(dashboard, resource),
        } 
      end

      def edit_set
        category_set
        @practice_content = Category.first.practice_contents
        @practice_menu = requested_resource.practice_menu_sets.select("*").joins(:practice_content).select("*")
      end

      def category_set
        @categories = Category.all
      end
  end
end
