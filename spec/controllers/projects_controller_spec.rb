require 'rails_helper'

describe ProjectsController do
  fixtures :projects

  let(:project) { projects(:one) }

  it "should get new" do
    get :new
    expect(response).to be_success
    expect(assigns :project).not_to be_nil
  end

  it "should create project" do
    expect do
      post :create, params: { project: { repo: 'foo/bar.git', github_host: 'github.internal.com' } }
    end.to change { Project.count }.by(1)

    p = assigns :project
    expect(p.repo).to eq('foo/bar.git')
    expect(p.github_host).to eq('github.internal.com')

    expect(response).to redirect_to(project_path(p))
  end

  it "should show project" do
    get :show, params: { id: project }
    expect(assigns :project).to eq(project)
    expect(response).to be_success
  end

  it "should edit project" do
    get :edit, params: { id: project }
    expect(assigns :project).to eq(project)
    expect(response).to be_success
  end

  describe "github host choices" do
    let(:other_host) { projects(:two) }

    context "without ENTERPRISE_HOSTS" do
      before do
        allow(ENV).to receive(:[]).with('ENTERPRISE_HOSTS').and_return(nil)
      end

      it "shouldn't offer a choice of github host" do
        get :new, params: { id: project }
        expect(assigns :hosts).to eq(["github.com"])
      end

      it "offers a choice if the project already specifies a different host" do
        get :edit, params: { id: other_host }
        expect(assigns :hosts).to eq(['github.com', other_host.github_host])
      end
    end

    context "with ENTERPRISE_HOSTS" do
      before do
        allow(ENV).to receive(:[]).with('ENTERPRISE_HOSTS').and_return(
          'github.starship-enterprise.com,github.galactica.com')
      end

      it "should offer a choice of github hosts" do
        get :new, params: { id: project }
        expect(assigns :hosts).to eq(%w{
          github.starship-enterprise.com
          github.galactica.com
          github.com
        })
      end

      it "offers the original host as a choice on existing projects" do
        get :edit, params: { id: other_host }
        expect(assigns :hosts).to eq([
          'github.starship-enterprise.com',
          'github.galactica.com',
          'github.com',
          other_host.github_host])
      end
    end
  end

  it "should update project" do
    patch :update, params: { id: project, project: {
      repo: 'something/different.git',
      github_host: 'github.something.com'
    } }

    p = assigns :project
    expect(p.repo).to eq('something/different.git')
    expect(p.github_host).to eq('github.something.com')

    assert_redirected_to project_path(assigns(:project))
  end

  it "should destroy project" do
    expect { delete :destroy, params: { id: project } }.to change { Project.count }.by(-1)

    expect(response).to redirect_to(root_path)
  end
end
