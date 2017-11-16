# inefficient API misuse checking results
Every tab in this Excel sheet shows checking results for one application with the application-name specified. 
The summary tab shows the aggregated results.
In every tab, each column shows the checking reuslt for one API misuse rule.
1. any? or count(*) > 0 => exists? 

    onebody/app/views/people/_pending_updates.haml:
    <pre>
    if @logged_in.can_update?(@person) and @person.updates.pending.count > 0
    </pre>
2. where.first? => find_by

    lobsters/app/models/keystore.rb:   
    <pre>
    self.where(:key => key).first
    </pre>
3. * => *.except(order)

    diaspora/app/models/user/querying.rb:
    <pre>
    @posts_per_day = Post.where("created_at >= ?", Date.today - 21.days).group("DATE(created_at)").order("DATE(created_at) ASC").count
    </pre>
4. each.update => update_all

    gitlabhq/app/models/members/project_member.rb: 
    <pre>
    members.each do |member|
        member.destroy
    end
    </pre>
5. .count => size

    gitlabhq/app/models/user.rb:
    <pre>
    keys.count == 0 && Gitlab::ProtocolAccess.allowed?('ssh')
    </pre>
6. .map => .pluck

    gitlabhq/app/services/merge_requests/refresh_service.rb:
    <pre>
    commit_ids = @commits.map(&:id)
    </pre>
7. pluck.sum => sum

    spree/core/app/models/spree/payment.rb: 
    <pre>
    offsets.pluck(:amount).sum
    </pre>
8. .pluck + pluck => SQL UNION
 
    spree/core/app/models/spree/zone.rb:   
    <pre>
    return false if (target.states.pluck(:id) - states.pluck(:id)).present?
    </pre>
9. if exists? find else create end => find_or_create_by

    discourse/app/models/group.rb 
    <pre> 
    def add_owner(user)
        if group_user = self.group_users.find_by(user: user)   
            group_user.update_attributes!(owner: true) if !group_user.owner 
        else
            GroupUser.create!(user: user, group: self, owner: true)
        end       
    end
    </pre>
